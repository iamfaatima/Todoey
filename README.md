# Todoey
UserDefaults, NSEncoder and implementing MVC 

Local data persistance
User defaults
1- let defaults = UserDefaults.standard
2- let item = defaults.array(forKey: “”) as ? String
3- self.defaults.set(appendedArray , forKey: “”)
NSEncoder
1- Create a custom data model and inherit from Encoder and Decoder
2- Create a file path:
let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first.appendingPathComponent(“items.plist”)
print it and go to that plist file(wont exist rn)
Note: userDomainMask is users personal home directory associated with this current app
3- for step two in user defaults:
Note: create a saveData method and call it for data and checkmark or any property.
let encoder = PropertyListEncoder()
put below line in do catch try
let data = encoder.encode(itemArray)
data.write(to: dataFilePath!)
Decoder:
loadData():
let data = Data(contentsOf: dataFilePath!)
let decoder = PropertyListDecoder()
itemArray = decoder.decode([Items].self,  from: data)
Note: [Items].self is the custom data type which you want to decode
