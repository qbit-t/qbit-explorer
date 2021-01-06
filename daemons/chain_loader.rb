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
        block_data = q.getblock(state_chain['chain'], height)
        p block_data
        block = Block.new
        block.chain_id = chain['id']
        block.height = height
        block.blockid = block_data['result']['id']
        block.save
        break
      end
      p height
    end
    p Chain.where("chain='#{state_chain['chain']}'").first
  end
  sleep(5)
}
