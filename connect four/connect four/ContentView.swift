//
//  ContentView.swift
//  connect four
//
//  Created by User14 on 2022/3/13.
//

import SwiftUI
/*struct Empty{
    var col:Int
    var btn:some View{
        Button(action: {
            
        }, label: {
            Image("empty")
                .resizable()
                .frame(width: 30, height: 30)
        })
    }
}*/
var board=Array(repeating: [0,0,0,0,0,0,0], count: 6)
let empty:some View=Image("empty")
    .resizable()
    .frame(width: 45, height:45)
let yellow:some View=Image("yellow")
    .resizable()
    .frame(width: 45, height:45)
let red:some View=Image("red")
    .resizable()
    .frame(width: 45, height: 45)
let win:some View=Image("win")
    .resizable()
    .frame(width: 45, height: 45)
var e_btn:some View=Button(action: {
    
}, label: {
    empty
})
var y_btn:some View=Button(action: {
    
}, label: {
    yellow
})
var r_btn:some View=Button(action: {
    
}, label: {
    red
})
var w_btn:some View=Button(action: {
    
}, label: {
    win
})

var arr2=Array(repeating:0,count:6)
var arr3=Array(repeating:0,count:6)
var arr4=Array(repeating:0,count:6)
var arr5=Array(repeating:0,count:6)
var arr6=Array(repeating:0,count:6)
var arr7=Array(repeating:0,count:6)
/*func modify(i:Int){
    if(i==1){
        for  j in(0..<6){
            if arr1[j]==0{
                arr1[j]=1;
                return
            }
        }
    }
}*/
struct ContentView: View {
    @State private var arr1=Array(repeating:0,count:6)
    var body: some View {
        /*VStack(spacing:0){
            ForEach (0..<6){ i in
                HStack(spacing:0){
                    ForEach  (0..<7){ j in
                        //var blk=block(x:i,y:j)
                        if board[i][j]==0{
                            e_btn
                        }
                        else if board[i][j]==1{
                            y_btn
                        }
                        else if board[i][j]==2{
                            r_btn
                        }
                        else {
                            w_btn
                        }
                    }
                }
            }
        }*/
        
        HStack(spacing:0){
            
            Button(action: {
                for  j in(0..<6){
                    if arr1[5-j]==0{
                        arr1[5-j]=1;
                        break;
                    }
                }
                
            }, label: {
                VStack(spacing:0){
                    ForEach(0..<6){ i in
                        switch arr1[i]{
                        case 0:
                            empty
                        case 1:
                            yellow
                        case 2:
                            red
                        case 3:
                            win
                        default:
                            empty
                        }
                        /*if arr1[i]==0{
                            empty
                        }
                        else if arr1[i]==1{
                            yellow
                        }
                        else if arr1[i]==2{
                            red
                        }
                        else {
                            win
                        }*/
                    }
                }
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           // ContentView()
        }
    }
}
