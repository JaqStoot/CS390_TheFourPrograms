open FsAlg.Generic
(*If FsAlg isn't installed install command below: 
dotnet add package FsAlg --version 0.5.13
*)

let mutable row1 = 0
let mutable col1 = 0
let mutable row2 = 0
let mutable col2 = 0

let getDims  = 
    let mutable invalid = true
    while invalid do
        printfn "Matrix 1 Dims"
        printfn "# Row 1: "
        row1 <- System.Console.ReadLine() |> int
        printfn "# Col 1: "
        col1 <- System.Console.ReadLine() |> int
        printfn "Matrix 2 Dims"
        printfn "# Row 2: "
        row2 <- System.Console.ReadLine() |> int
        printfn "# Col 2: "
        col2 <- System.Console.ReadLine() |> int

        if col1 <> row2 then
            printfn "Invalid dimensions \n\n"
            row1, row2, col1,  col2 <- 0
            invalid <- true
        else
            invalid <- false


let setData limit_r limit_c = 
    let mat = Matrix.create limit_r limit_c 0.
    let mutable input = 0.0
    for i in 0 .. limit_r-1 do
        for j in 0 .. limit_c-1 do
            input <- System.Console.ReadLine() |> float;
            mat[i,j] <- input
    mat
    
let main() = 
    getDims 
    printfn "Enter values into Matrix 1:"
    let m1 = setData row1 col1

    printfn "Enter values into Matrix 2:"
    let m2 = setData row2 col2

    let m3 = m1 * m2 //matrix multiplication :|
    
    printfn "===== Matrix 1 ====="
    printfn "%A" (m1)
    printfn "\n===== Matrix 2 ====="
    printfn "%A" (m2)
    printfn "\n===== Result ====="
    printfn "%A" (m3)

main()
