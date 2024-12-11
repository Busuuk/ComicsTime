//
//  MangaAPIManager.swift
//  ComicsTime
//
//  Created by Simone Di Blasi on 10/12/24.
//


import SwiftUI

struct MangaAPIManager: View {
    @State private var manga: Manga?
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let manga = manga {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Immagine di copertina
                        AsyncImage(url: URL(string: manga.thumb)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)

                        // Titolo
                        Text(manga.title)
                            .font(.title)
                            .bold()

                        // Autori
                        Text("Autori: \(manga.authors.joined(separator: ", "))")
                            .font(.subheadline)

                        // Generi
                        Text("Generi: \(manga.genres.joined(separator: ", "))")
                            .font(.subheadline)

                        // Riassunto
                        Text("Riassunto:")
                            .font(.headline)
                        Text(manga.summary)
                            .font(.body)

                        // Tipo e NSFW
                        Text("Tipo: \(manga.type.capitalized)")
                        if manga.nsfw {
                            Text("⚠️ Contenuto NSFW")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }
            } else {
                if let errorMessage = errorMessage {
                    Text("Errore: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    Text("Caricamento...")
                }
            }
        }
        .onAppear(perform: fetchManga)
    }

    func fetchManga() {
        guard let url = URL(string: "https://manga-series.p.rapidapi.com/manga/{id}") else {
            errorMessage = "URL non valido"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("manga-series.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("8f9a4144f2msh3b70d14188f177dp1f9210jsn7907d6458b7c", forHTTPHeaderField: "x-rapidapi-key")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Errore: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "Nessun dato ricevuto"
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(MangaResponse.self, from: data)
                DispatchQueue.main.async {
                    manga = decodedResponse.data
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Errore nella decodifica dei dati: \(error)"
                }
            }
        }

        task.resume()
    }
}
