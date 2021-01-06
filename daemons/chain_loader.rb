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
      sql ="select max(height) as heigth from blocks where chain_id=#{chain['id']}"
      res = ActiveRecord::Base.connection.exec_query(sql).first
      height = res['height'] || 0
      while height < state_chain['height']
        height = height + 1
      end
      p height
    end
    p Chain.where("chain='#{state_chain['chain']}'").first
  end
  sleep(5)
}
