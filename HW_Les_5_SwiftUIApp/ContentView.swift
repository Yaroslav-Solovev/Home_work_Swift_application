import SwiftUI

struct ContentView: View{
    @State var news: [News] = []
    private var networkService = NetworkService()

    var body: some View{
        List(news) {news in 
            Vstack{
                Text(Helper.getDate(date: news.date))
                    .font(.body)
                    .fontWeight(.light)
                Text(news.title)
                    .font(.title)
                    .fontWeight(.heavy)
            }
        }
            .onAppear{
                networkService.getNews{
                    (news) in self.news = news
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        contentView()
    }
}