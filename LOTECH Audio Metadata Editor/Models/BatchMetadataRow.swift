import Foundation

struct BatchMetadataRow: Identifiable, Hashable, Sendable {
    enum Status: Hashable, Sendable {
        case pending
        case loading
        case loaded
        case readOnly
        case saving
        case saved
        case failed(String)

        var displayText: String {
            switch self {
            case .pending:
                "Pending"
            case .loading:
                "Loading"
            case .loaded:
                "Ready"
            case .readOnly:
                "Read-only"
            case .saving:
                "Saving"
            case .saved:
                "Saved"
            case let .failed(message):
                message
            }
        }
    }

    let id: URL
    let audioFile: AudioFile
    var originalMetadata: AudioMetadata
    var title: String
    var artist: String
    var contributingArtist: String
    var album: String
    var releaseYear: String
    var genre: String
    var status: Status

    init(audioFile: AudioFile) {
        id = audioFile.url
        self.audioFile = audioFile
        originalMetadata = audioFile.metadata
        title = audioFile.metadata.title
        artist = audioFile.metadata.artist
        contributingArtist = audioFile.metadata.contributingArtist
        album = audioFile.metadata.album
        releaseYear = audioFile.metadata.releaseYear
        genre = audioFile.metadata.genre
        status = audioFile.supportsMetadataWriting ? .pending : .readOnly
    }

    var fileName: String {
        audioFile.fileName
    }

    var isEditable: Bool {
        audioFile.supportsMetadataWriting
    }

    var hasDraftChanges: Bool {
        isEditable && (
            title != originalMetadata.title ||
            artist != originalMetadata.artist ||
            contributingArtist != originalMetadata.contributingArtist ||
            album != originalMetadata.album ||
            releaseYear != originalMetadata.releaseYear ||
            genre != originalMetadata.genre
        )
    }

    mutating func applyLoadedMetadata(_ metadata: AudioMetadata) {
        originalMetadata = metadata
        title = metadata.title
        artist = metadata.artist
        contributingArtist = metadata.contributingArtist
        album = metadata.album
        releaseYear = metadata.releaseYear
        genre = metadata.genre
        status = isEditable ? .loaded : .readOnly
    }

    mutating func discardDraftChanges() {
        title = originalMetadata.title
        artist = originalMetadata.artist
        contributingArtist = originalMetadata.contributingArtist
        album = originalMetadata.album
        releaseYear = originalMetadata.releaseYear
        genre = originalMetadata.genre
        status = isEditable ? .loaded : .readOnly
    }

    var metadataForSaving: AudioMetadata {
        var metadata = originalMetadata
        metadata.title = title
        metadata.artist = artist
        metadata.contributingArtist = contributingArtist
        metadata.album = album
        metadata.releaseYear = releaseYear
        metadata.genre = genre
        return metadata
    }
}
