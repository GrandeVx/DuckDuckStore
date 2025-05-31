<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSS Test Page</title>

    <!-- Using absolute paths with context path -->
    <link rel="stylesheet" href="${contextPath}/css/design-system.css">
    <link rel="stylesheet" href="${contextPath}/css/header.css">
    <link rel="stylesheet" href="${contextPath}/css/footer.css">

    <style>
      .test-container {
        padding: 20px;
        margin: 20px;
        background-color: var(--color-primary);
        color: var(--color-white);
        border-radius: var(--radius-md);
      }

      .context-path {
        font-weight: bold;
        color: var(--color-secondary);
      }
    </style>
  </head>

  <body>
    <div class="test-container">
      <h1>CSS Loading Test</h1>
      <p>Context Path: <span class="context-path">${contextPath}</span></p>
      <p>If this background is pink and this text is white, the CSS is loading correctly.</p>
    </div>

    <div class="container">
      <h2>Design System Components Test</h2>
      <div class="mb-4">
        <button class="btn btn-primary">Primary Button</button>
        <button class="btn btn-secondary">Secondary Button</button>
        <button class="btn btn-accent">Accent Button</button>
      </div>

      <div class="card mb-4" style="max-width: 300px;">
        <div class="card-body">
          <h3 class="card-title">Card Component</h3>
          <p class="card-text">This is a test card to verify if design system styles are loaded correctly.</p>
        </div>
      </div>
    </div>

    <div class="container">
      <h2>Current CSS Loading Method</h2>
      <pre style="background: #f5f5f5; padding: 15px; border-radius: 8px;">
&lt;link rel="stylesheet" href="css/design-system.css"&gt;
        </pre>

      <h2>Proposed Absolute Path Solution</h2>
      <pre style="background: #f5f5f5; padding: 15px; border-radius: 8px;">
&lt;link rel="stylesheet" href="${contextPath}/css/design-system.css"&gt;
        </pre>
    </div>
  </body>

  </html>