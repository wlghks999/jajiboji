import Foundation

var n = 10
var limit = 3
var power = 2


func solution(number : Int, limit : Int, power : Int) -> Int{
    var i1 = 1
    var i2 = 1
    var p = 0
    var indexP = [Int]()
    var total = 0
    var i3 = 0
    
    
    while (i1 <= number){
        
        while (i2 <= i1){
            if (i1 % i2 == 0){
                p = p + 1
            }
            
            i2 = i2 + 1
        }
        indexP.append(p)
        p = 0
        
        i2 = 1
        i1 = i1 + 1
        
        
        
    }
    
    
    while (i3 < indexP.count){
        if indexP[i3] > limit{
            total = total + power
        }else{
            total = total + indexP[i3]
        }
        
        i3 = i3 + 1
    }
    
    
    return total
}


print(String(solution(number: n, limit: limit, power: power)))
