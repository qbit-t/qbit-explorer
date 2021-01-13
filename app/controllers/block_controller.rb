class BlockController < ApplicationController

  def get_transactions(block_id)
    transactions = Block.find_by_sql("select * from transactions where block_id=#{block_id}")
    result = []
    transactions.each do |tx|
      result << [tx.height, tx.txid, tx.created_at.to_s]
    end
    return result
  end

  def show
    @block = Block.find_by_blockid(params[:id])
    @chain = Chain.find_by_id(@block.chain_id)
    @transactions = get_transactions(@block.id)
  end

end
