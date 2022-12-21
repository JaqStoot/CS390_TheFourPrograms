open System
let rec quicksort list =
    match list with
    | [] ->
        []
    | highIndex::otherElems ->
        let lowIndex = 
            otherElems
            |> List.filter (fun e -> e < highIndex)
            |> quicksort
        let largerElem = 
            otherElems
            |> List.filter (fun e -> e >= highIndex)
            |> quicksort
        List.concat [lowIndex; [highIndex]; largerElem]

let rec getNumList listSoFar =
    let ok, num = Int32.TryParse(Console.ReadLine())
    match ok with
        | false -> listSoFar
        | true -> getNumList (num::listSoFar)

let main() =
    printfn("Enter how ever many numbers you'd like, to stop hit enter twice.")
    let l = getNumList []    
    printfn "%A" (quicksort l)

main()