class ExplorerController < ApplicationController
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
