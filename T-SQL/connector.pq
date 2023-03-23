let 
    Source = Sql.Database("localhost","ContosoRetailDW"),
    Table = Source({[Schema = "dbo", Item="DimStore"]})[Data],
    SelectColumns =Table.SelectColumns(Table,{"Date", "StoreType", "StoreLocation"})
in
    Table