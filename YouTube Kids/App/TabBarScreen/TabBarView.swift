//
//  TabBarView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import SwiftUI

struct TabBarView: View {
    @State var appStorage = AppStorage<VideoItem>()
    var body: some View {
        TabView {
            Tab("Featured", systemImage: "video.circle.fill") {
                FeaturedVideosView(
                    model: FeaturedVideosModelAgent(appStorage: appStorage),
                    videos: mockList
                )
            }
            
            Tab("Saved", systemImage: "bookmark.circle") {
                List(appStorage.storage, id: \.id) { video in
                    VideoPreviewView(model: VideoPreviewModel(storage: appStorage, item: video))
                        .listRowSeparator(.hidden)
                        .padding(.bottom)
                }
                .listStyle(.plain)
                .scrollIndicatorsFlash(onAppear: true)
            }
            .badge(appStorage.storage.count)
        }
        .tabViewStyle(.tabBarOnly)
    }
}

#Preview {
    TabBarView()
}

let mockList: [VideoEntity] = [
    VideoEntity(id: UUID(), channel: "TechVerse", title: "Swift 6 Overview", views: 120_000, duration: 540, rating: 4.8),
    VideoEntity(id: UUID(), channel: "GameZone", title: "Top 10 PS5 Games", views: 980_000, duration: 620, rating: 4.7),
    VideoEntity(id: UUID(), channel: "Foodies", title: "How to Make Ramen", views: 310_000, duration: 460, rating: 4.9),
    VideoEntity(id: UUID(), channel: "SciWorld", title: "Black Holes Explained", views: 450_000, duration: 780, rating: 4.6),
    VideoEntity(id: UUID(), channel: "MusicLife", title: "Top 2025 Hits", views: 2_300_000, duration: 400, rating: 4.3),
    VideoEntity(id: UUID(), channel: "DailyFacts", title: "50 Amazing Facts", views: 860_000, duration: 360, rating: 4.2),
    VideoEntity(id: UUID(), channel: "ArtStation", title: "Speed Painting a Dragon", views: 150_000, duration: 900, rating: 4.9),
    VideoEntity(id: UUID(), channel: "MovieTalk", title: "Oscar Predictions 2025", views: 290_000, duration: 540, rating: 4.4),
    VideoEntity(id: UUID(), channel: "FitnessPlus", title: "20 Min Full Body Workout", views: 710_000, duration: 1200, rating: 4.8),
    VideoEntity(id: UUID(), channel: "CodeCraft", title: "React vs SwiftUI", views: 230_000, duration: 720, rating: 4.5),
    VideoEntity(id: UUID(), channel: "AutoDaily", title: "2025 Tesla Review", views: 530_000, duration: 660, rating: 4.6),
    VideoEntity(id: UUID(), channel: "TravelVibes", title: "Hidden Gems of Iceland", views: 180_000, duration: 800, rating: 4.7),
    VideoEntity(id: UUID(), channel: "BookBinge", title: "Top 5 Sci-Fi Books", views: 110_000, duration: 520, rating: 4.4),
    VideoEntity(id: UUID(), channel: "ChefMode", title: "The Perfect Lasagna", views: 360_000, duration: 1080, rating: 4.9),
    VideoEntity(id: UUID(), channel: "HistoryNuts", title: "WWII in 10 Minutes", views: 420_000, duration: 600, rating: 4.6),
    VideoEntity(id: UUID(), channel: "MusicTheory", title: "How Chords Work", views: 75_000, duration: 450, rating: 4.7),
    VideoEntity(id: UUID(), channel: "MindMatters", title: "The Psychology of Fear", views: 98_000, duration: 500, rating: 4.8),
    VideoEntity(id: UUID(), channel: "SketchDaily", title: "Drawing Faces 101", views: 140_000, duration: 840, rating: 4.9),
    VideoEntity(id: UUID(), channel: "RetroTech", title: "Old Tech That Still Works", views: 270_000, duration: 780, rating: 4.5),
    VideoEntity(id: UUID(), channel: "EcoLiving", title: "Zero-Waste Hacks", views: 90_000, duration: 300, rating: 4.6),
    VideoEntity(id: UUID(), channel: "LangLearner", title: "Learn Spanish Fast", views: 390_000, duration: 960, rating: 4.7),
    VideoEntity(id: UUID(), channel: "DocuWorld", title: "Inside the Amazon Rainforest", views: 610_000, duration: 1500, rating: 4.9),
    VideoEntity(id: UUID(), channel: "MotoMadness", title: "Fastest Bikes 2025", views: 320_000, duration: 400, rating: 4.3),
    VideoEntity(id: UUID(), channel: "PetWorld", title: "Why Cats Purr", views: 220_000, duration: 280, rating: 4.4),
    VideoEntity(id: UUID(), channel: "CryptoDive", title: "Is Bitcoin Dead?", views: 560_000, duration: 700, rating: 4.1),
    VideoEntity(id: UUID(), channel: "UXLab", title: "Mobile UX Trends 2025", views: 105_000, duration: 550, rating: 4.5),
    VideoEntity(id: UUID(), channel: "DIYKing", title: "Make a Bookshelf", views: 160_000, duration: 720, rating: 4.8),
    VideoEntity(id: UUID(), channel: "GadgetGuy", title: "Top 5 Smartwatches", views: 470_000, duration: 380, rating: 4.4),
    VideoEntity(id: UUID(), channel: "SneakerWorld", title: "Rare Jordans Unboxed", views: 380_000, duration: 620, rating: 4.6),
    VideoEntity(id: UUID(), channel: "OceanLife", title: "Coral Reefs in Danger", views: 190_000, duration: 840, rating: 4.7),
    VideoEntity(id: UUID(), channel: "TheBuilder", title: "Backyard Patio DIY", views: 200_000, duration: 960, rating: 4.5),
    VideoEntity(id: UUID(), channel: "SpeedMath", title: "Mental Math Tricks", views: 310_000, duration: 270, rating: 4.9),
    VideoEntity(id: UUID(), channel: "AnimeNow", title: "Top Anime of the Year", views: 880_000, duration: 480, rating: 4.6),
    VideoEntity(id: UUID(), channel: "DroneDaily", title: "Epic Drone Shots", views: 330_000, duration: 560, rating: 4.8),
    VideoEntity(id: UUID(), channel: "CodeBits", title: "Understanding Async", views: 210_000, duration: 600, rating: 4.7),
    VideoEntity(id: UUID(), channel: "VlogCity", title: "Life in Tokyo", views: 300_000, duration: 1020, rating: 4.6),
    VideoEntity(id: UUID(), channel: "AutoFix", title: "Fixing Car Scratches", views: 95_000, duration: 480, rating: 4.3),
    VideoEntity(id: UUID(), channel: "PlantLife", title: "Indoor Plants Guide", views: 150_000, duration: 720, rating: 4.5),
    VideoEntity(id: UUID(), channel: "SpaceNews", title: "Mars Mission 2025", views: 670_000, duration: 840, rating: 4.8),
    VideoEntity(id: UUID(), channel: "HowItWorks", title: "Inside a Jet Engine", views: 560_000, duration: 900, rating: 4.7),
    VideoEntity(id: UUID(), channel: "LogicLand", title: "What Is a Paradox?", views: 240_000, duration: 390, rating: 4.6),
    VideoEntity(id: UUID(), channel: "MakeMusic", title: "GarageBand Basics", views: 130_000, duration: 600, rating: 4.4),
    VideoEntity(id: UUID(), channel: "BeatLab", title: "Making Beats from Scratch", views: 310_000, duration: 780, rating: 4.8),
    VideoEntity(id: UUID(), channel: "KidsWorld", title: "Fun Science for Kids", views: 520_000, duration: 360, rating: 4.9),
    VideoEntity(id: UUID(), channel: "HorrorHouse", title: "Creepiest Urban Legends", views: 410_000, duration: 660, rating: 4.6),
    VideoEntity(id: UUID(), channel: "FutureTech", title: "AI in 2030", views: 390_000, duration: 720, rating: 4.7),
    VideoEntity(id: UUID(), channel: "InvestorPro", title: "How to Retire Early", views: 275_000, duration: 880, rating: 4.5),
    VideoEntity(id: UUID(), channel: "JokeZone", title: "Try Not to Laugh", views: 1_200_000, duration: 300, rating: 4.2),
    VideoEntity(id: UUID(), channel: "RetroGames", title: "Best SNES Games", views: 430_000, duration: 520, rating: 4.6),
    VideoEntity(id: UUID(), channel: "StartupTalk", title: "How to Pitch an Idea", views: 145_000, duration: 570, rating: 4.5),
    VideoEntity(id: UUID(), channel: "EduTech", title: "Gamification in Learning", views: 225_000, duration: 620, rating: 4.4),
    VideoEntity(id: UUID(), channel: "LanguageFun", title: "Fun With Idioms", views: 88_000, duration: 300, rating: 4.6),
    VideoEntity(id: UUID(), channel: "Drone101", title: "Build Your First Drone", views: 175_000, duration: 1100, rating: 4.7),
    VideoEntity(id: UUID(), channel: "CleanLife", title: "Declutter Your Home", views: 205_000, duration: 620, rating: 4.5),
    VideoEntity(id: UUID(), channel: "MindHack", title: "Boost Focus in 5 Steps", views: 315_000, duration: 420, rating: 4.8),
    VideoEntity(id: UUID(), channel: "NightSky", title: "April Meteor Showers", views: 95_000, duration: 540, rating: 4.7),
    VideoEntity(id: UUID(), channel: "AskPhysics", title: "What Is Time?", views: 360_000, duration: 720, rating: 4.9),
    VideoEntity(id: UUID(), channel: "Craftopia", title: "DIY Wall Art", views: 120_000, duration: 480, rating: 4.6),
    VideoEntity(id: UUID(), channel: "WildLens", title: "Tigers in the Wild", views: 300_000, duration: 900, rating: 4.9),
    VideoEntity(id: UUID(), channel: "ZenVibes", title: "Relaxing Water Sounds", views: 810_000, duration: 1800, rating: 4.8)
]
