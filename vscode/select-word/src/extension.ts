import * as vscode from "vscode"

// characters that end a "whole word" (only outside brackets opened within the word)
const isSeparator = (char: string) => /[\s,]/.test(char)

const pairs: Record<string, string> = { "(": ")", "[": "]", "{": "}" }
const closers: Record<string, string> = { ")": "(", "]": "[", "}": "{" }

// scan left: a closer opens a nested block, an opener without its closer belongs to an outer block
function findStart(text: string, from: number) {
  const stack: string[] = []
  let i = from
  while (i > 0) {
    const char = text[i - 1]
    if (closers[char]) stack.push(char)
    else if (pairs[char]) {
      if (stack.at(-1) !== pairs[char]) break
      stack.pop()
    } else if (!stack.length && isSeparator(char)) break
    i--
  }
  return i
}

// scan right: an opener opens a nested block, a closer without its opener belongs to an outer block
function findEnd(text: string, from: number) {
  const stack: string[] = []
  let i = from
  while (i < text.length) {
    const char = text[i]
    if (pairs[char]) stack.push(char)
    else if (closers[char]) {
      if (stack.at(-1) !== closers[char]) break
      stack.pop()
    } else if (!stack.length && isSeparator(char)) break
    i++
  }
  return i
}

export function activate(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand("selectWord.select", () => {
      const editor = vscode.window.activeTextEditor
      if (!editor) return

      editor.selections = editor.selections.map((selection) => {
        const { line } = selection.active
        const text = editor.document.lineAt(line).text

        const start = selection.start.line === line ? selection.start.character : 0
        const end = selection.end.line === line ? selection.end.character : text.length

        return new vscode.Selection(line, findStart(text, start), line, findEnd(text, end))
      })
    }),
  )
}

export function deactivate() {}
