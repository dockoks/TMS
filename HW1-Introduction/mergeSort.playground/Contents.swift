func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let middleIndex = array.count / 2
    let leftArray = Array(array[0..<middleIndex])
    let rightArray = Array(array[middleIndex..<array.count])
    
    let sortedLeftArray = mergeSort(leftArray)
    let sortedRightArray = mergeSort(rightArray)
    
    return merge(sortedLeftArray, sortedRightArray)
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var result: [T] = []
    

    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        } else {
            result.append(right[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        result.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        result.append(right[rightIndex])
        rightIndex += 1
    }
    
    return result
}

print(mergeSort(["😮‍💨", "😆", "🔻", "🥲", "🗿"]))
print(mergeSort([3, 5, 2, 1, 6, 99]))
print(mergeSort(["banana", "coco", "apple", "carrot", "mango"]))

