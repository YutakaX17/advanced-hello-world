import { expect, test } from "@playwright/test";

test("saves text and confirms success", async ({ page }) => {
  await page.goto("/");

  await expect(page.getByRole("heading", { name: "Hello World" })).toBeVisible();
  await page.getByLabel("Text").fill("Saved by Playwright");
  await page.getByRole("button", { name: "Save" }).click();

  await expect(page.getByRole("heading", { name: "Saved" })).toBeVisible();
  await expect(page.getByText("Text successfully saved.")).toBeVisible();
});

test("rejects an empty submission in the browser", async ({ page }) => {
  await page.goto("/");
  await page.getByRole("button", { name: "Save" }).click();
  await expect(page.getByRole("alert")).toContainText("Enter some text");
});

