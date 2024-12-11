//
//  LibraryView.swift
//  ComicsTime
//
//  Created by Simone Di Blasi on 11/12/24.
//
import SwiftUI

struct LibraryView: View {
    @State private var myMangaList: [Manga] = [] // Manga aggiunti dall'utente

    var body: some View {
        NavigationView {
            List(myMangaList) { manga in
                NavigationLink(destination: MangaDetailView(manga: manga)) {
                    HStack {
                        AsyncImage(url: URL(string: manga.thumb)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 70)
                        .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(manga.title)
                                .font(.headline)
                            Text(manga.genres.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("La Mia Lista")
        }
    }
}
#Preview {
    ContentView()
}
