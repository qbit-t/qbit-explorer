class TransactionController < ApplicationController

  def show
    @tx = Transaction.find_by_txid(params[:id])
    @block = Block.find_by_id(@tx.block_id)
    @chain = Chain.find_by_id(@tx.chain_id)
    q = Qbit.new
    @tx_data = q.gettransaction(params[:id])
    p @tx_data
  end

  def raw
    p params["format"]
    q = Qbit.new
    @tx_data = q.gettransaction(params["format"])
    @pp = JSON.pretty_generate(@tx_data)
  end

end
