require ENV["RAILS_ENV_PATH"]

def log(msg)
  puts msg
end

loop { 
  log "run chain load"
  q = Qbit.new
  state = q.getstate
  p state['result']
  state['result']['state']['chains'].each do |state_chain|
    puts "load blocks for chain #{state_chain['chain']} till block #{state_chain['height']}"
    chain = Chain.where("chain='#{state_chain['chain']}'").first
    if chain
      p chain['id']
      sql ="select max(height) as height from blocks where chain_id=#{chain['id']}"
      res = ActiveRecord::Base.connection.exec_query(sql).first
      p res
      height = res['height'] || 0
      p height
      while height < state_chain['height']
        height = height + 1
        p height
        block_data = q.getblock(state_chain['chain'], height)
        full_block_data = q.getfullblock(block_data['result']['id'])
        #p full_block_data
        block = Block.new
        block.chain_id = chain['id']
        block.height = height
        block.blockid = block_data['result']['id']
        block.time = block_data['result']['time']
        block.save
        full_block_data['result']['transactions'].each do |transaction|
          tx = Transaction.new
          tx.block_id = block.id
          tx.txid = transaction['id']
          tx.chain_id = chain['id']
          tx.height = height
          tx.time = block.time
          tx.save
          tx_data_resp = q.gettransaction(transaction['id'])
          tx_data = tx_data_resp['result']
          tx_data['in'].each do |input|
            if input['asset'] && input['address'] && input['value']
              moving = Moving.new
              moving.asset = input['asset']
              moving.address =  input['address']
              moving.amount = -(input['value'].to_f)
              moving.txid = transaction['id']
              moving.time = block.time
              moving.save
            end
          end
          tx_data['out'].each do |out|
            if out['asset'] && out['address'] && out['value']
              moving = Moving.new
              moving.asset = out['asset']
              moving.address =  out['address']
              moving.amount = out['value'].to_f
              moving.txid = transaction['id']
              moving.time = block.time
              moving.save
            end
          end

          if tx_data['type'] == 'asset_type'
            tx_props = tx_data['properties']
            asset = Asset.new
            asset.description = tx_props['description']
            asset.emission = tx_props['emission']
            asset.entity = tx_props['entity']
            asset.scale = tx_props['scale']
            asset.supply = tx_props['supply']
            asset.typetx = transaction['id']
            asset.save
          end
          if tx_data['type'] == 'asset_emission'
            tx_data['out'].each do |out|
              asset = Asset.find_by_typetx(out['asset'])
              if asset
                asset.emissiontx = transaction['id']
                asset.save
              end
            end
          end
        end
        #break
      end
      p height
    end
    p Chain.where("chain='#{state_chain['chain']}'").first
  end
  sleep(5)
}
