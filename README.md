# LOTECH Audio Metadata Editor

A lightweight macOS application for viewing, organizing and editing audio metadata one file or hundreds of files at a time.

Unlike traditional tag editors that focus on editing one song at a time, LOTECH Audio Metadata Editor provides both a detailed Single Edit view and a spreadsheet-style Batch Edit view, making it practical to clean large music collections quickly.

This app is part of the **LOTECH** family of practical desktop utilities built to reduce friction and help people get real work done.

---

# Why LOTECH Audio Metadata Editor?

Managing audio metadata should feel like managing a spreadsheet, not opening hundreds of individual dialogs.

LOTECH combines:

- Single-file editing for detailed work
- Spreadsheet-style batch editing for large collections
- Local processing with no cloud dependency
- Clean, beginner-friendly interface
- Professional metadata handling without exposing technical complexity

---

# Features

## Single Edit

Inspect and edit metadata for an individual audio file.

Supported fields include:

- Title
- Artist
- Album
- Album Artist
- Track Number
- Disc Number
- Year
- Genre
- Composer
- Comment
- Lyrics (where supported)
- Embedded Artwork
- File information

Artwork can be previewed and replaced where supported by the audio format.

---

## Batch Edit

The Batch Edit view is designed for users managing hundreds or thousands of music files.

Instead of opening one file after another, metadata is presented in a spreadsheet-style table.

Supported workflow includes:

- Multi-row selection
- Batch metadata editing
- Spreadsheet-style editing
- Sortable columns
- Resizable columns
- Folder-based editing
- Batch rename
- Undo / Redo
- Metadata status tracking
- Search and filtering

This dramatically reduces the time required to organize large music libraries.

---

# ID3 Handling

MP3 files are automatically normalized to **ID3v2** when saved.

Users are not expected to understand differences between ID3v1, ID3v2.3 and ID3v2.4.

The application chooses sensible defaults so users can focus on organizing their music instead of learning metadata standards.

---

# Local First

All metadata editing happens locally on your Mac.

No files are uploaded.

No cloud services are required.

Future AI-assisted features will remain optional and require the user to provide their own AI provider or API key.

---

# LOTECH Philosophy

LOTECH builds focused desktop tools that solve everyday problems without unnecessary complexity.

The goal is not to become another bloated media manager.

The goal is to provide fast, reliable tools that users enjoy opening because they stay out of the way.

---

# Current Status

Version: **1.1.0**

Current release includes:

- Single Edit mode
- Spreadsheet Batch Edit mode
- Batch rename
- Artwork editing
- Undo / Redo
- Folder-scoped editing
- ID3v2 normalization

---

# Known Limitations

- Some audio formats expose different writable metadata fields.
- Not every format supports embedded artwork.
- Always keep backups before performing large batch edits.

---

# Developer Documentation

- docs/Architecture.md
- docs/Metadata.md

---

# Roadmap

Future directions include:

- Additional audio formats
- Smarter artwork management
- AI-assisted metadata suggestions
- LOTECH AI SDK integration
- Council SDK integration

---

# License

Released under the MIT License.

See `LICENSE`.

---

# Disclaimer

This software is provided **as-is**, without warranty.

Always keep backups before editing valuable media collections.
