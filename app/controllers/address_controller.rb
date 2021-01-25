class AddressController < ApplicationController

  def show
    p params
    address = params['id']
    @address = address
    sql = "select sum(amount) balance from movings where address='#{address}';"
    res = ActiveRecord::Base.connection.exec_query(sql)
    @balance = res[0]['balance']
    sql = "select sum(amount) income from movings where address='#{address}' and amount>0;"
    res = ActiveRecord::Base.connection.exec_query(sql)
    @income = res[0]['income']
    sql = "select sum(amount) outgoing from movings where address='#{address}' and amount<0;"
    res = ActiveRecord::Base.connection.exec_query(sql)
    @outgoing = res[0]['outgoing'] || 0
    sql = "select * from movings where address='#{address}' order by time desc limit 50;"
    @movings = Moving.find_by_sql(sql)
  end

end
