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
    assets_db = Asset.find_by_sql('select * from assets')
    @assets = []
    assets_db.each do |asset|
      a = {}
      a[:entity] = asset['entity']
      a[:type] = asset['type']
      @assets << a
    end

    a = {}
    a[:entity] = 'QBIT'
    a[:type] = '579f7204a773c1ba6bf121670119546c2224630f0dec7917d71609d36d71c44e'
    @assets << a

    @assets.each do |asset|
      asset_type = asset[:type]
      sql = "select sum(amount) balance from movings where address='#{address}' and asset='#{asset_type}';"
      res = ActiveRecord::Base.connection.exec_query(sql)
      asset[:balance] = res[0]['balance']
      sql = "select sum(amount) income from movings where address='#{address}' and amount>0 and asset='#{asset_type}';"
      res = ActiveRecord::Base.connection.exec_query(sql)
      asset[:income] = res[0]['income']
      sql = "select sum(amount) outgoing from movings where address='#{address}' and amount<0 and asset='#{asset_type}';"
      res = ActiveRecord::Base.connection.exec_query(sql)
      asset[:outgoing] = res[0]['outgoing'] || 0
      sql = "select * from movings where address='#{address}' and asset='#{asset_type}' order by time desc limit 50;"
      asset[:movings] = Moving.find_by_sql(sql)
    end
  end

end
