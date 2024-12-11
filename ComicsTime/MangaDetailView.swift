//
//  MangaDetailView.swift
//  ComicsTime
//
//  Created by Simone Di Blasi on 11/12/24.
//
import SwiftUI

struct MangaDetailView: View {
    let manga: Manga // Modello con i dati del manga

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Immagine del manga
                AsyncImage(url: URL(string: manga.thumb)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)

                // Titolo e sottotitolo
                Text(manga.title)
                    .font(.title)
                    .bold()

                if !manga.subTitle.isEmpty {
                    Text(manga.subTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Generi
                if !manga.genres.isEmpty {
                    Text("Generi: \(manga.genres.joined(separator: ", "))")
                        .font(.subheadline)
                }

                // Riassunto
                Text("Riassunto:")
                    .font(.headline)
                Text(manga.summary)
                    .font(.body)

                // Autori
                if !manga.authors.isEmpty {
                    Text("Autori: \(manga.authors.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(.top, 8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Dettaglio Manga")
    }
}
