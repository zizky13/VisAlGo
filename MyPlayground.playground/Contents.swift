import Foundation

//let driving = { (place: String) -> String in
//    return "I am driving to \(place)"
//}
//
//let travelCost = { (destination: String) -> Int in
//    switch destination {
//    case "US":
//        return 18_000_000
//    case "UK":
//        return 20_000_000
//    case "Singapore":
//        return 2_000_000
//    default:
//        return 0
//    }
//}
//
//print("If you were going to uk, the cost would be \(travelCost("UK"))")


//func animate(duration: Double, animations: () -> Void) {
//    print("Starting a \(duration) second animation...")
//    animations()
//}
//
//animate(duration: 2) {
//    print("Slide in")
//}

//func cek(_ cekParam: () -> Void) {
//    print("Cek")
//    cekParam()
//}
//
//cek {
//    print("Cek 2")
//}

//func study(reviseNotes: (String) -> Void) {
//    let notes = "Napoleon was a short, dead dude."
//    for _ in 1...10 {
//        reviseNotes(notes)
//    }
//}
//study { (notes: String) in
//    print("I'm reading my notes: \(notes)")
//}

func makeRandomNumberGenerator() -> () -> Int {
    var prevNumber = 0;
    
    return {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 1...10)
            
        } while newNumber == prevNumber
        
        prevNumber = newNumber
        return newNumber
    }
}


let generator = makeRandomNumberGenerator()

for _ in 0..<2 {
    print(generator())
}
