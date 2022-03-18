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
    @State private var game_end=0
    @State private var y_remain:Int=21
    @State private var r_remain:Int=21
    @State private var log:String=""
@State private var y_pt:Int=0
@State private var r_pt:Int=0
@State private var p2:String="Player 2"
@State private var time:Double=0.0
@State private var time_start:Int=1
@State private var time_reset:Int=0
@State private var game_time:Timer?
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
          func reset(){
                    for i in(0..<6){
                              for j in(0..<7){
                                        board[i][j]=0
                              }
                    }
                    y_remain=21
                    r_remain=21
                    count=0
                    lock=0
                    game_end=0
                    log=""
                    time_reset=1
                    time_start=1
          }
    var body: some View {
VStack(spacing:5){
          HStack{
                    Text("⏰")
                    Text("\(String(format: "%.1f", time))")
          }
          HStack{
                    VStack{
                              Text("Player 1")
                              Text("\(y_pt)").font(.system(size:50))
                              
                    }
                    Button{
                              if(lock==0){
                                        if(p2=="BOT"){
                                                  p2="Player 2"
                                        }
                                        else{
                                                  p2="BOT"
                                        }
                                        reset()
                              }
                    }label:{
                              Text("Switch mode")
                    }
                    VStack{
                              Text(p2)
                              Text("\(r_pt)").font(.system(size:50))
                    }
          }
          
  HStack{
      HStack{
          Image("yellow")
          .resizable()
          .frame(width: 50, height:50)
          Text("\(y_remain)")
                    .font(.largeTitle).foregroundColor(Color.yellow)
      }
      HStack{
          Image("red")
          .resizable()
          .frame(width: 50, height:50)
          Text("\(r_remain)")
                    .font(.largeTitle).foregroundColor(Color.red)
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
                                              if lock==0 && game_end==0{//不能同時放兩個 遊戲結束不能按
                                                  board[i][j]=count%2+1
                                                  if time_start==1{
                                                            time_start=0
                                                            game_time=Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { t in
                                                                      if time_reset==1{
                                                                                time=0
                                                                                time_reset=0
                                                                                t.invalidate()
                                                                      }
                                                                      else if game_end==0{
                                                                                time+=0.1
                                                                      }
                                                            }
                                                  }
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
                                                                    log="TIE"
                                                                      game_end=1
                                                                      lock=0
                                                            }
                                                          else if tmp==0{
                                                               lock=0
                                                          }
                                                          else{
                                                            if(count%2==1){
                                                                      log=p2+" win"
                                                                      r_pt+=1
                                                                      game_end=1
                                                            }
                                                            else{
                                                                      log="Player 1 win"
                                                                      y_pt+=1
                                                                      game_end=1
                                                            }
                                                            lock=0
                                                          }
                                                          count=count+1
                                                      }
                                                  }
                                                  if p2=="BOT"{//電腦打牌
                                                            board[i][j]=count%2+1
                                                            var stop=0
                                                            var curr=0
                                                            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ timer in
                                                                      /*Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { ttimer in
                                                                          if destroy == 1 {
                                                                              ttimer.invalidate()
                                                                          }
                                                                          else if curr+1<6 && board[current+1][j]==0{
                                                                              var tmp=board[current][j]
                                                                              board[curr][j]=board[curr+1][j]
                                                                              board[curr+1][j]=tmp
                                                                              curr=curr+1
                                                                          }
                                                                          else{
                                                                              var tmp:Int=ifwin()
                                                                              stop=1
                                                                                if count%2==1{
                                                                                    r_remain = r_remain-1
                                                                                }
                                                                                else{
                                                                                    y_remain = y_remain-1
                                                                                }
                                                                                if r_remain == 0{//game end
                                                                                        log="TIE"
                                                                                          game_end=1
                                                                                          lock=0
                                                                                }
                                                                              else if tmp==0{
                                                                                   lock=0
                                                                              }
                                                                              else{
                                                                                if(count%2==1){
                                                                                          log=p2+" win"
                                                                                          r_pt+=1
                                                                                          game_end=1
                                                                                }
                                                                                else{
                                                                                          log="Player 1 win"
                                                                                          y_pt+=1
                                                                                          game_end=1
                                                                                }
                                                                                lock=0
                                                                              }
                                                                              count=count+1
                                                                          }
                                                                      }*/
                                                            }
                                                            count=count+1
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
                    HStack{
                              Text(log).font(.largeTitle).foregroundColor(Color.green)
                              Button{
                                        if(lock==0){
                                                  reset()
                                        }
                              }label:{
                                        Text("Reset").font(.largeTitle)
                              }
                    }
                    
          }
          
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
