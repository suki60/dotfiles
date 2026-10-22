import * as vscode from "vscode"

export function activate(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand("copyAtMention.copy", async () => {
      const editor = vscode.window.activeTextEditor
      if (!editor) return

      const { start, end } = editor.selection
      // diff editors show the original side as a git: (or similar) uri, which
      // asRelativePath can't match to a workspace folder, so map it back to file:
      const { uri } = editor.document
      const fileUri = uri.scheme === "file" ? uri : vscode.Uri.file(uri.fsPath)
      const path = vscode.workspace.asRelativePath(fileUri, false)

      // a selection ending at column 0 of a later line doesn't include that line
      const startLine = start.line + 1
      const endLine = end.line + 1 - (!editor.selection.isEmpty && end.character === 0 && end.line > start.line ? 1 : 0)

      const range = startLine === endLine ? `${startLine}` : `${startLine}-${endLine}`
      const mention = editor.selection.isEmpty ? `@${path}` : `@${path}#${range}`

      await vscode.env.clipboard.writeText(mention)
      vscode.window.setStatusBarMessage(`Copied ${mention}`, 2000)
    }),
  )
}

export function deactivate() {}
