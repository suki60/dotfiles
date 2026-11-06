import * as vscode from "vscode"
import { execFile } from "child_process"

// the slice of the built-in git extension's API this uses
type Repository = { rootUri: vscode.Uri; inputBox: { value: string } }
type GitApi = { repositories: Repository[]; getRepository(uri: vscode.Uri): Repository | null }

function runClaude(cwd: string, prompt: string): Promise<string> {
  return new Promise((resolve, reject) => {
    execFile(
      "claude",
      ["-p", "--no-session-persistence", "--model", "haiku", prompt],
      { cwd },
      (error, stdout, stderr) => (error ? reject(new Error(stderr || error.message)) : resolve(stdout)),
    )
  })
}

// runs a skill that prints a commit message and puts it in the Source Control box
async function fillMessage(prompt: string) {
  const git: GitApi = vscode.extensions.getExtension("vscode.git")!.exports.getAPI(1)

  // the repo of the open file, so multi-root workspaces pick the right one
  const uri = vscode.window.activeTextEditor?.document.uri
  const repo = (uri && git.getRepository(uri)) ?? git.repositories[0]
  if (!repo) return

  const skill = prompt.split(" ")[0]

  try {
    const output = await vscode.window.withProgress(
      { location: vscode.ProgressLocation.SourceControl },
      () => runClaude(repo.rootUri.fsPath, prompt),
    )

    // the skill prints the message alone in the first fenced block
    const message = output.match(/```[^\n]*\n([\s\S]*?)\n```/)?.[1].trim()

    if (!message) {
      vscode.window.showErrorMessage(`${skill} returned no message: ${output.trim()}`)
      return
    }

    repo.inputBox.value = message
  } catch (error) {
    vscode.window.showErrorMessage(`${skill} failed: ${(error as Error).message}`)
  }
}

export function activate(context: vscode.ExtensionContext) {
  context.subscriptions.push(
    vscode.commands.registerCommand("scmMessage.generate", () => fillMessage("/km")),
    vscode.commands.registerCommand("scmMessage.stage", async () => {
      const description = (await vscode.window.showInputBox({ prompt: "Describe the changes to stage" }))?.trim()
      if (!description) return
      await fillMessage(`/ks ${description}`)
    }),
  )
}

export function deactivate() {}
