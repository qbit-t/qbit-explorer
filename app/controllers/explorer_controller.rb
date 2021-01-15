class ExplorerController < ApplicationController
  def get_blocks(chain_id, limit=10)
    blocks = Block.find_by_sql("select * from blocks where chain_id=#{chain_id} order by id desc limit 10")
    result = []
    blocks.each do |block|
      result << [block.height, block.blockid, block.created_at.to_s]
    end
    return result
  end

  def get_transactions(chain_id, limit=10)
    transactions = Block.find_by_sql("select * from transactions where chain_id=#{chain_id} order by id desc limit 10")
    result = []
    transactions.each do |tx|
      result << [tx.height, tx.txid, tx.created_at.to_s]
    end
    return result
  end

  def get_data(blocks_limit=10, transactions_limit=10)
    chains_db = Chain.find_by_sql('select * from chains')
    q = Qbit.new
    state = q.getstate
    @chains = []
    chains_db.each do |chain|
      c = {}
      c[:name] = chain['name']
      c[:chain] = chain['chain']
      c[:dapp] = chain['dapp']
      c[:blocks] = get_blocks(chain['id'], blocks_limit)
      c[:transactions] = get_transactions(chain['id'], transactions_limit)
      state['result']['state']['chains'].each do |state_chain|
        c[:height] = state_chain['height']
        c[:time] = state_chain['time']
        c[:state] = state_chain['state']
      end
      @chains << c
    end
    p @chains
  end


  def index
    get_data
  end

  def blocks
    get_data(20, 0)
  end

  def transactions
  end


end
