class ExplorerController < ApplicationController
  def get_blocks(chain_id, limit=10)
    blocks = Block.find_by_sql("select * from blocks where chain_id=#{chain_id} order by id desc limit #{limit}")
    result = []
    blocks.each do |block|
      result << [block.height, block.blockid, Time.at(block.time).to_s]
    end
    return result
  end

  def get_transactions(chain_id, limit=10)
    transactions = Block.find_by_sql("select * from transactions where chain_id=#{chain_id} order by id desc limit #{limit}")
    result = []
    transactions.each do |tx|
      result << [tx.height, tx.txid, Time.at(tx.time).to_s]
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
    p params
    if params["q"]
      search params["q"]
    end
    get_data
  end

  def blocks
    get_data(20, 0)
  end

  def transactions
    get_data(0,20)
  end

  def assets
    assets_data = Asset.find_by_sql("select * from assets")
    @assets = []
    assets_data.each do |a|
      @assets << [a.entity, a.description, a.emission, a.scale, a.supply, a.supply.to_f/a.scale.to_f, a.typetx, a.emissiontx]
    end
  end

  def search(query)
    p query
    if query && query != ""
      block = Block.find_by_blockid(query)
      p block
      if block
        redirect_to "/block/"+query
      end
      tx = Transaction.find_by_txid(query)
      if tx
        redirect_to "/transaction/"+query
      end
    else
      #not found
    end
  end
end
