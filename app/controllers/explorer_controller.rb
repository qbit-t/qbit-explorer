class ExplorerController < ApplicationController
  def get_blocks(chain_id)
    blocks = Block.find_by_sql("select * from blocks where chain_id=#{chain_id} order by id desc limit 10")
    result = []
    blocks.each do |block|
      result << [block.height, block.blockid, block.created_at.to_s]
    end
    return result
  end

  def index
    chains_db = Chain.find_by_sql('select * from chains')
    q = Qbit.new
    state = q.getstate
    @chains = []
    chains_db.each do |chain|
      c = {}
      c[:name] = chain['name']
      c[:chain] = chain['chain']
      c[:dapp] = chain['dapp']
      c[:blocks] = get_blocks(chain['id'])
      state['result']['state']['chains'].each do |state_chain|
        c[:height] = state_chain['height']
        c[:time] = state_chain['time']
        c[:state] = state_chain['state']
      end
      @chains << c
    end
    p @chains
  end

  def blocks
  end

  def transactions
  end
end
