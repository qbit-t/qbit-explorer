class AddressController < ApplicationController

  def show
    p params
    address = params['id']
    @address = address
    assets_data = []
    assets_db = Asset.find_by_sql('select * from assets')
    assets_db.each do |asset|
      a = {}
      a[:entity] = asset['entity']
      a[:type] = asset['typetx']
      assets_data << a
    end

    a = {}
    a[:entity] = 'QBIT'
    a[:type] = '0f690892c0c5ebc826a3c51321178ef816171bb81570d9c3b7573e102c6de601'
    assets_data << a

    @assets = []
    assets_data.each do |asset|
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
      sql = "select * from movings where address='#{address}' and asset='#{asset_type}' order by time desc limit 20;"
      asset[:movings] = Moving.find_by_sql(sql)
      if asset[:balance]
        @assets << asset
      end
    end
  end

end
