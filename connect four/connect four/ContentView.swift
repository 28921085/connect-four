//
//  ContentView.swift
//  connect four
//
//  Created by User14 on 2022/3/13.
//

import SwiftUI
struct ContentView: View {
    @State private var board=Array(repeating: [0,0,0,0,0,0,0], count: 6)
    @State private var count=0
    @State private var lock=0
    @State private var y_remain:Int=21
    @State private var r_remain:Int=21
    @State private var reset=0
func ifwin()->Int{
        var color:Int=count%2+1
        for i in (0..<6){
            for j in(0..<7){
                var c:Int=1
                if(i+3<6){//下
                    for x in(0..<4){
                        if(board[i+x][j] != color){
                            c=0
                        }
                    }
                    if(c==1){
                        for x in(0..<4){
                            board[i+x][j]=666
                        }
                        return 1
                    }
                    c=1
                }
                if(j+3<7){//右
                    for x in(0..<4){
                        if(board[i][j+x] != color){
                            c=0
                        }
                    }
                    if(c==1){
                        for x in(0..<4){
                            board[i][j+x]=666
                        }
                        return 1
                    }
                    c=1
                }
                if(i+3<6 && j+3<7){//右下
                    for x in(0..<4){
                        if(board[i+x][j+x] != color){
                            c=0
                        }
                    }
                    if(c==1){
                        for x in(0..<4){
                            board[i+x][j+x]=666
                        }
                        return 1
                    }
                    c=1
                }
                if(i-3 > -1 && j+3<6){//右上
                    for x in(0..<4){
                        if(board[i-x][j+x] != color){
                            c=0
                        }
                    }
                    if(c==1){
                        for x in(0..<4){
                            board[i-x][j+x]=666
                        }
                        return 1
                    }
                    c=1
                }
            }
        }
        return 0
    }
    
    var body: some View {
          if reset==0{
                  VStack{
                      HStack{
                          HStack{
                              Image("yellow")
                              .resizable()
                              .frame(width: 80, height:80)
                              Text("\(y_remain)")
                                        .font(.largeTitle)
                          }
                          HStack{
                              Image("red")
                              .resizable()
                              .frame(width: 80, height:80)
                              Text("\(r_remain)")
                                        .font(.largeTitle)
                          }
                      }
                      VStack(spacing:0){
                             ForEach (0..<6){ i in
                                    HStack(spacing:0){
                                        ForEach  (0..<7){ j in
                                            if board[i][j]==0{
                                                Image("empty")
                                                    .resizable()
                                                    .frame(width: 45, height:45)
                                                    .onTapGesture {
                                                        if lock==0{//不能同時放兩個
                                                            board[i][j]=count%2+1
                                                            var current=i
                                                            var destroy=0
                                                            lock=1
                                                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                                                                if destroy == 1 {
                                                                    timer.invalidate()
                                                                }
                                                                else if current+1<6 && board[current+1][j]==0{
                                                                    var tmp=board[current][j]
                                                                    board[current][j]=board[current+1][j]
                                                                    board[current+1][j]=tmp
                                                                    current=current+1
                                                                }
                                                                else{
                                                                    var tmp:Int=ifwin()
                                                                    destroy=1
                                                                      if count%2==1{
                                                                          r_remain = r_remain-1
                                                                      }
                                                                      else{
                                                                          y_remain = y_remain-1
                                                                      }
                                                                      if r_remain == 0{//game end
                                                                               reset=1
                                                                      }
                                                                    else if tmp==0{
                                                                         lock=0
                                                                    }
                                                                    count=count+1
                                                                }
                                                            }
                                                        }
                                                    }
                                                        
                                            }
                                            else if board[i][j]==1{
                                                Image("yellow")
                                                    .resizable()
                                                    .frame(width: 45, height:45)
                                            }
                                            else if board[i][j]==2{
                                                Image("red")
                                                    .resizable()
                                                    .frame(width: 45, height:45)
                                            }
                                            else {
                                                Image("win")
                                                    .resizable()
                                                    .frame(width: 45, height:45)
                                            }
                                        }
                                    }
                                }
                            }
                        }
              }
          else{
                    reset=1
                    for i in(0..<6){
                              for j in (0..<7){
                                        board[i][j]=0
                              }
                    }
                    
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
