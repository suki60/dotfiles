import { Action, ActionPanel, Icon, List } from "@raycast/api";
import { useFrecencySorting } from "@raycast/utils";
import { readdirSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import { useState } from "react";

const REPOS_DIR = join(homedir(), "Documents/repos");
const VSCODE = "com.microsoft.VSCode";

type Repo = { id: string; name: string; path: string };

function getRepos(): Repo[] {
  return readdirSync(REPOS_DIR, { withFileTypes: true })
    .filter((entry) => entry.isDirectory() && !entry.name.startsWith("."))
    .map((entry) => ({ id: entry.name, name: entry.name, path: join(REPOS_DIR, entry.name) }));
}

export default function Command() {
  const [repos] = useState(getRepos);
  // Repos you open most often float to the top; unvisited ones stay alphabetical
  const { data, visitItem, resetRanking } = useFrecencySorting(repos, {
    sortUnvisited: (a, b) => a.name.localeCompare(b.name),
  });

  return (
    <List searchBarPlaceholder="Search repos...">
      {data.map((repo) => (
        <List.Item
          key={repo.id}
          icon={Icon.Folder}
          title={repo.name}
          actions={
            <ActionPanel>
              <Action.Open
                title="Open in VS Code"
                icon={Icon.Code}
                target={repo.path}
                application={VSCODE}
                onOpen={() => visitItem(repo)}
              />
              <Action.ShowInFinder path={repo.path} onShow={() => visitItem(repo)} />
              <Action.CopyToClipboard
                title="Copy Path"
                content={repo.path}
                shortcut={{ modifiers: ["cmd", "shift"], key: "c" }}
              />
              <Action
                title="Reset Ranking"
                icon={Icon.ArrowCounterClockwise}
                onAction={() => resetRanking(repo)}
              />
            </ActionPanel>
          }
        />
      ))}
    </List>
  );
}
