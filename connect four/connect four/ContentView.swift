import SwiftUI
import AVFoundation
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
@State private var filename1:[String]=["yellow","pac man","coin"]
@State private var filename2:[String]=["red","bowling"]
@State private var index1:Int=0
@State private var index2:Int=0
@State private var now:String="Player 1"
let player = AVPlayer()
let player2 = AVPlayer()
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
                    Text(now+" turn")
                    Text("⏰")
                    Text("\(String(format: "%.1f", time))")
                              
          }
          HStack{
                    VStack{
                              Text("Player 1")
                                        .onAppear{
                                        let fileUrl = Bundle.main.url(forResource: "bgm", withExtension: "mp3")!
                                                        let playerItem = AVPlayerItem(url: fileUrl)
                                                        self.player.replaceCurrentItem(with: playerItem)
                                                        self.player.play()
                              }
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
          Image(filename1[index1])
          .resizable()
          .frame(width: 50, height:50)
          .onTapGesture{
                    index1=(index1+1)%3
          }
          Text("\(y_remain)")
                    .font(.largeTitle).foregroundColor(Color.yellow)
      }
      HStack{
          Image(filename2[index2])
          .resizable()
          .frame(width: 50, height:50)
          .onTapGesture{
                    index2=(index2+1)%2
          }
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
                                                  let fileUrl2 = Bundle.main.url(forResource: "click", withExtension: "mp3")!
                                                                  let playerItem2 = AVPlayerItem(url: fileUrl2)
                                                                  self.player2.replaceCurrentItem(with: playerItem2)
                                                  self.player2.play()
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
                                                            if r_remain == 0 && tmp != 1{//game end
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
                                                            
                                                            if p2=="BOT" && game_end==0 {//電腦打牌
                                                                      
                                                                      var rd=Int.random(in:0..<6)
                                                                      while board[0][rd] != 0{
                                                                                rd=Int.random(in:0..<6)
                                                                      }
                                                                      board[0][rd]=count%2+1
                                                                      var stop=0
                                                                      var curr=0
                                                                      lock=1
                                                                      Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ timerr in
                                                                                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { ttimer in
                                                                                    if stop == 1 {
                                                                                        ttimer.invalidate()
                                                                                    }
                                                                                    else if curr+1<6 && board[curr+1][rd]==0{
                                                                                        var tmp=board[curr][rd]
                                                                                        board[curr][rd]=board[curr+1][rd]
                                                                                        board[curr+1][rd]=tmp
                                                                                        curr=curr+1
                                                                                    }
                                                                                    else{
                                                                                        var tmp:Int=ifwin()
                                                                                        stop=1
                                                                                          r_remain = r_remain-1
                                                                                          if r_remain == 0 && tmp != 1{//game end
                                                                                                  log="TIE"
                                                                                                    game_end=1
                                                                                                    lock=0
                                                                                          }
                                                                                        else if tmp==0{
                                                                                             lock=0
                                                                                        }
                                                                                        else{
                                                                                                    log=p2+" win"
                                                                                                    r_pt+=1
                                                                                                    game_end=1
                                                                                                    lock=0
                                                                                        }
                                                                                        count=count+1
                                                                                    }
                                                                                }
                                                                      }
                                                                      now="Player 1"
                                                            }
                                                      }
                                                  }
                                                  if count%2 == 1{
                                                            now="Player 1"
                                                  }
                                                  else{
                                                            now=p2
                                                  }
                                              }
                                          }
                                  }
                                  else if board[i][j]==1{
                                      Image(filename1[index1])
                                          .resizable()
                                          .frame(width: 45, height:45)
                                  }
                                  else if board[i][j]==2{
                                      Image(filename2[index2])
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
