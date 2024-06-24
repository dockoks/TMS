# Enum report 

## Definition

An `optional` lets a variable of any type represent a lack of value. In Objective-C, the absence of value is available only in reference types using the nil special value. Value types, such as int or float, do not have this ability.

Swift extends the lack of value concept to both reference and value types with optionals. An optional variable can hold either a value or nil, indicating a lack of value.

## Ways to unwrap an optional

> [!NOTE]  
> Safe unwrapping options below.

### 1. Implicitly unwrapped
```swift
if let a = x {
  print("x was successfully unwrapped and is = \(a)")
}
```

### 2. Optional chaining
```swift
let a = x?.count
```

### 3. Nil coalescing
```swift
let a = x ?? ""
```

### 4. Guard statement
```swift
guard let a = x else {
  return
}
```

### 5. Optional pattern
```swift
if case let a? = x {
  print(a)
}
```

> [!CAUTION]
> Unsafe unwrapping options below.

### 6. Forced unwrapping
```swift
let a: String = x!
```

### 7. Implicitly unwrapped
```swift
var a = x!
```