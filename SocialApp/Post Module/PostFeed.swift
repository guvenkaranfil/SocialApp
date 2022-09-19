//
//  PostFeed.swift
//  SocialApp
//
//  Created by Güven Karanfil on 19.09.2022.
//

import SwiftUI

struct PostFeed: View {
    @ObservedObject var feedPresenter: FeedPresenter
    @ObservedObject var postInteractor: PostInteractor
    
    init(feedPresenter: FeedPresenter, postInteractor: PostInteractor) {
        self.feedPresenter = feedPresenter
        self.postInteractor =  postInteractor
    }
    
    @State private var text: String = "Lorem ipsum"
    @State private var image = UIImage()
    @State private var showSheet = false
    
    var body: some View {
        VStack() {
            Form {
                TextEditor(text: $text)
                    .lineLimit(3)
                    .border(.gray, width: 1)
                    .textFieldStyle(.roundedBorder)
                    .padding(16)
                    .frame(width: nil, height: 150, alignment: .center)
                    .accessibilityIdentifier("postFeedTextfield")

                Spacer(minLength: 50)
                HStack {
                    Image(uiImage: self.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)

                     Text("Pick a Photo")
                         .font(.headline)
                         .frame(maxWidth: .infinity)
                         .frame(height: 50)
                         .background(Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)))
                         .cornerRadius(16)
                         .foregroundColor(.white)
                             .padding(.horizontal, 20)
                             .onTapGesture {
                                showSheet = true
                             }
                        }
                .padding(.horizontal, 20)
                .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)}
                
                Spacer(minLength: 50)
                Text(self.feedPresenter.isPosting ? "Submitting..." : "Submit")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onTapGesture {                        
                        let item = FeedItem(
                            id: UUID(),
                            name: self.postInteractor.currentUser!.name,
                            username: self.postInteractor.currentUser!.username,
                            profileIcon: self.postInteractor.currentUser!.profileIcon,
                            text: self.text,
                            imageURL: URL(string: "http://any-url.com")!,
                            image: self.image)
                        
                        self.feedPresenter.onSubmit(item: item)
                    }
                    .disabled(self.feedPresenter.isPosting)
                
                Spacer(minLength: 25)
            }
        }
    }
}

struct PostFeed_Previews: PreviewProvider {
    static var previews: some View {
        
        let url = URL(string: "http://any-url.com")!
        let client = URLSessionHTTPClient(session: .shared)
        let remoteLoader = RemoteFeedLoader(client: client, url: url)
        PostFeed(
            feedPresenter: FeedPresenter(
                interactor: FeedInteractor(loader: remoteLoader)),
            postInteractor: PostInteractor())
    }
}
