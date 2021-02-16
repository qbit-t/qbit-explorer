require ENV["RAILS_ENV_PATH"]

def log(msg)
  puts msg
end

logger = Logger.new("#{Rails.root}/log/chain_loader.log")

loop {
begin 
  #log "run chain load"
  q = Qbit.new
  state = q.getstate
  state['result']['state']['chains'].each do |state_chain|
    logger.info "load blocks for chain #{state_chain['chain']} till block #{state_chain['height']}"
    chain = Chain.where("chain='#{state_chain['chain']}'").first
    if chain
      #p chain['id']
      sql ="select max(height) as height from blocks where chain_id=#{chain['id']}"
      res = ActiveRecord::Base.connection.exec_query(sql).first
      height = res['height'] || 0
      max_height = state_chain['height']-5
      logger.info "#{height} of #{max_height}"
      while height < max_height
        height = height + 1
        logger.info "#{height}"
        block_data = q.getblock(state_chain['chain'], height)
        full_block_data = q.getfullblock(block_data['result']['id'])
        #p full_block_data
        block = Block.new
        block.chain_id = chain['id']
        block.height = height
        block.blockid = block_data['result']['id']
        block.time = block_data['result']['time']
        block.bits = block_data['result']['bits']
        block.save
        full_block_data['result']['transactions'].each do |transaction|
          tx_data_resp = q.gettransaction(transaction['id'])
          tx_data = tx_data_resp['result']
          if tx_data == nil
            logger.info "#{transaction['id']}"
            logger.info "#{tx_data_resp}"
          end
          tx = Transaction.new
          tx.block_id = block.id
          tx.txid = transaction['id']
          tx.chain_id = chain['id']
          tx.height = height
          tx.time = block.time
          tx.save
          tx_data['in'].each do |input|
            #puts "index #{input['index']}"
            if input['index'] >= 0
              intx_data_resp = q.gettransaction(input['tx'])
              intx_data = intx_data_resp['result']
              intx_out = intx_data['out'][input['index']]
              if intx_out['asset'] && intx_out['address'] && intx_out['value']
                moving = Moving.new
                moving.asset = intx_out['asset']
                moving.address =  intx_out['address']
                moving.amount = -(intx_out['value'].to_f)
                moving.txid = transaction['id']
                moving.time = block.time
                moving.save
              end
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
    end
  end
  sleep(5)
rescue Exception => e
  logger.info "#{e.message}"
  logger.info "#{e.backtrace.inspect}"
end
}
