# VS Code and MCP Configuration

This directory contains configuration for VS Code and Model Context Protocol (MCP) servers to enhance Claude Code functionality.

## MCP Server Setup

### Quick Setup
1. **Copy the template**: `cp mcp.json.template mcp.json`
2. **Setup GitHub token**: 
   - Create a GitHub Personal Access Token at https://github.com/settings/tokens
   - Replace `your-github-token-here` in `mcp.json` with your actual token
   - Required scopes: `repo`, `workflow`, `actions:read`
3. **VS Code restart**: Restart VS Code to load the MCP servers
4. **Install servers**: MCP servers will auto-install when Claude Code needs them

### Available Servers

#### GitHub Server
- **Purpose**: Access GitHub repositories, issues, PRs, and workflows
- **Useful for**: Managing course issues, tracking deployments, code reviews
- **Examples**:
  - "Check the status of our latest GitHub Actions run"
  - "Create an issue for the notebook deployment bug"
  - "Review the recent pull requests"

#### Filesystem Server  
- **Purpose**: Enhanced file analysis and search across the project
- **Useful for**: Code pattern analysis, notebook content search
- **Examples**:
  - "Find all notebooks that mention Unity Catalog"
  - "Analyze the structure of our Terraform configurations"
  - "Search for specific Spark functions across all course materials"

### Security Notes

- `mcp.json` is gitignored to prevent exposing local file paths
- The template uses relative paths (`.`) for security
- Always use the template when sharing or contributing to public repositories

### Extending MCP

You can add additional servers for:
- **Terraform state inspection**
- **Course content management** 
- **Documentation search**
- **Custom project-specific tools**

See the main repository documentation for examples of custom MCP server implementations.

## Troubleshooting

### Server Installation Issues
If MCP servers fail to install:
```bash
# Install servers manually
npx -y @github/mcp-server-github
npx -y @modelcontextprotocol/server-filesystem
```

### Permission Issues
Ensure Claude Code has permission to:
- Access the project directory
- Execute npm/npx commands
- Connect to configured servers

### Configuration Validation
Check your MCP configuration with:
```bash
# Validate JSON syntax
cat mcp.json | python -m json.tool
```