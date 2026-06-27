import SwiftUI

struct BatchEditView: View {
    @Binding var rows: [BatchMetadataRow]
    @Binding var selection: Set<BatchMetadataRow.ID>
    let isLoading: Bool
    let isSaving: Bool
    let hasDraftChanges: Bool
    let onSave: () -> Void
    let onDiscard: () -> Void
    let onReload: () -> Void
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            table
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(nsColor: .textBackgroundColor))
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline, spacing: 16) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Batch Edit")
                    .font(.title2.weight(.semibold))
                Text(summaryText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: onReload) {
                Label("Reload", systemImage: "arrow.clockwise")
            }
            .disabled(isLoading || isSaving || hasDraftChanges)

            Button(role: .destructive, action: onDiscard) {
                Label("Discard", systemImage: "arrow.uturn.backward")
            }
            .disabled(!hasDraftChanges || isLoading || isSaving)

            Button(action: onSave) {
                Label("Save Changes", systemImage: "square.and.arrow.down")
            }
            .buttonStyle(.borderedProminent)
            .disabled(!hasDraftChanges || isLoading || isSaving)

            Button(action: onDone) {
                Label("Done", systemImage: "checkmark")
            }
            .disabled(isLoading || isSaving)
        }
        .padding(.horizontal, 28)
        .padding(.top, 28)
        .padding(.bottom, 18)
    }

    private var table: some View {
        Group {
            if rows.isEmpty {
                emptyState
            } else {
                Table($rows, selection: $selection) {
                    TableColumn("File") { $row in
                        Text(row.fileName)
                            .lineLimit(1)
                    }
                    .width(min: 180, ideal: 240)

                    TableColumn("Title") { $row in
                        editableField("Title", text: $row.title, row: row)
                    }
                    .width(min: 100, ideal: 170)

                    TableColumn("Artist") { $row in
                        editableField("Artist", text: $row.artist, row: row)
                    }
                    .width(min: 100, ideal: 170)

                    TableColumn("Album") { $row in
                        editableField("Album", text: $row.album, row: row)
                    }
                    .width(min: 100, ideal: 170)

                    TableColumn("Year") { $row in
                        editableField("Year", text: $row.releaseYear, row: row)
                    }
                    .width(min: 70, ideal: 90)

                    TableColumn("Genre") { $row in
                        editableField("Genre", text: $row.genre, row: row)
                    }
                    .width(min: 90, ideal: 140)

                    TableColumn("Status") { $row in
                        statusView(for: row.status)
                    }
                    .width(min: 120, ideal: 180)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "tablecells")
                .font(.system(size: 42, weight: .regular))
                .foregroundStyle(.secondary)

            Text("No batch-editable files")
                .font(.title3.weight(.semibold))

            Text("Open a folder containing supported audio files.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var summaryText: String {
        if isLoading {
            return "Loading metadata"
        }

        if isSaving {
            return "Saving changes"
        }

        let changedCount = rows.filter(\.hasDraftChanges).count

        if changedCount > 0 {
            return "\(changedCount) unsaved change\(changedCount == 1 ? "" : "s")"
        }

        return "\(rows.count) file\(rows.count == 1 ? "" : "s") loaded"
    }

    private func statusView(for status: BatchMetadataRow.Status) -> some View {
        Text(status.displayText)
            .font(.caption)
            .foregroundStyle(statusColor(for: status))
            .lineLimit(1)
    }

    private func statusColor(for status: BatchMetadataRow.Status) -> Color {
        switch status {
        case .failed:
            .red
        case .readOnly:
            .secondary
        case .saved:
            .green
        default:
            .secondary
        }
    }

    private func editableField(_ title: String, text: Binding<String>, row: BatchMetadataRow) -> some View {
        TextField(title, text: text)
            .textFieldStyle(.plain)
            .disabled(!row.isEditable || isLoading || isSaving)
    }
}
