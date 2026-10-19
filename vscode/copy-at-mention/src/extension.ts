import * as vscode from "vscode"

export function activate(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand("copyAtMention.copy", async () => {
      const editor = vscode.window.activeTextEditor
      if (!editor) return

      const { start, end } = editor.selection
      const path = vscode.workspace.asRelativePath(editor.document.uri, false)

      // a selection ending at column 0 of a later line doesn't include that line
      const startLine = start.line + 1
      const endLine = end.line + 1 - (!editor.selection.isEmpty && end.character === 0 && end.line > start.line ? 1 : 0)

      const range = startLine === endLine ? `${startLine}` : `${startLine}-${endLine}`
      const mention = `@${path}#${range}`

      await vscode.env.clipboard.writeText(mention)
      vscode.window.setStatusBarMessage(`Copied ${mention}`, 2000)
    }),
  )
}

export function deactivate() {}
