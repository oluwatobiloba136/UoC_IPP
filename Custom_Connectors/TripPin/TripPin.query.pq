let
    Source = TripPin.Feed("https://services.odata.org/v4/TripPinService/"),
    People = Source{[Name="People"]}[Data],
    SelectColumns = Table.SelectColumns(People, {"UserName", "FirstName", "LastName"})
in
    SelectColumns

// let 
//     Source = TripPin.Feed("https://services.odata.org/v4/TripPinService/Me")
// in
//     Source
