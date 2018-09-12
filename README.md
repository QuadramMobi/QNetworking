# QNetworking

## Installation
```ruby
pod 'QNetworking', :git => 'https://bitbucket.org/qios/qnetworking.git'
```

## FormDataEncoder
### Usage
Create an object that conforms to `FormTransformable`
```swift
import QNetworking

struct MyForm {
    let id: Int
    let photo: Data
    let filePDF: Data
}

extension MyForm: FormTransformable {
    var formDict: [String : Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["photo"] = photo
        dict["file"] = FormFile(name: "FileName", data: filePDF, type: "application/pdf", fileName: "name" + ".pdf")
        return dict
    }
}
```
Use  `FormDataEncoder` to encode your object to the data that will be sent to the server

```swift
let form = MyForm(...)
let formEnc = FormDataEncoder(boundary: API_BOUNDARY)
let data = try? formEnc.encode(form)
```

### Advanced use
There are two internal structs that you will normally don't need,  `FormField` and `FormFile`, the former will be converted from your key:value dict and the latter from your key:data dict, but will be automatically use a jpg MIME type and name, if you need to use another MIME type you will have to use FormFile directly like the example in Usage.

## QRequestable

Conform your enum to `QRequestable` so you get acces a to `.request` that gives you an `URLRequest`

### Usage

```swift
enum API {
    case login(username: String)
    case pub(id: Int)
}

extension API: QRequestable {
    /* Conform to QRequestable */
}
```
Use it for your `URLSession`

```
let dataTask = URLSession.shared.dataTask(with: API.pub(id: 3).request)
```

## Examples  

You can see CNMV for a simple example and Tappear for more advanced use.



