﻿module Day10
   
let (++) (x1,y1) (x2,y2) = (x1+x2, y1+y2)
let (--) (x1,y1) (x2,y2) = (x1-x2, y1-y2)

let rec gcd x y =
    match x, y with
    | 0, 0 -> 1
    | _, 0 -> x
    | _    -> gcd y (x % y)

let normalize (x,y) =
    let g = gcd x y |> abs
    (x/g, y/g)

let findOnVector p1 p2 ps =
    if p1 = p2 then
        Some p1
    else
        let nv = normalize (p2--p1)

        let mutable current = p1
        let mutable collision = None

        while current <> p2 do
            current <- current ++ nv
            if collision = None && current <> p2 && Seq.contains current ps then
                collision <- Some current
                current <- p2
        collision
            
let countVisible p1 ps =
    ps
    |> Seq.map (fun p2 -> findOnVector p1 p2 ps)
    |> Seq.sumBy (fun o -> match o with None -> 1 | Some _ -> 0)

let cwAngle (x,y) =
    let a = System.Math.Atan2(float x, float y)
    if a > 0.0 then
        System.Math.PI * 2.0  - a
    else
        a * -1.0

let sqrDist (x1,y1) (x2,y2) = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)

let asteroids = System.IO.File.ReadAllLines("day10input.txt")
                |> Seq.indexed
                |> Seq.collect (fun (y,s) ->
                    s.ToCharArray()
                    |> Seq.indexed
                    |> Seq.filter (fun (_,c) -> c = '#')
                    |> Seq.map (fun (x,c) -> (x,y)))

let part1() =
    asteroids
    |> Seq.map (fun p -> (p, countVisible p asteroids))
    |> Seq.maxBy snd
    |> printfn "%O"

let part2 () =
    let o = (26, 29)

    let map = asteroids
             |> Seq.filter ((<>) o)
             |> Seq.map (fun p -> cwAngle (o--p), (p, sqrDist o p))
             |> Seq.sortBy (fun (a,(_,d)) -> a,d)
             |> List.ofSeq
             |> List.groupBy fst
             |> Map.ofList

    let mutable c = 1

    for KeyValue(_,ps) in map do
        printfn "\t%i: %O" c ps.[0]
        c <- c+1