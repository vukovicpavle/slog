# Project brief: Slog — Local Community App

> Linked issue: https://github.com/vukovicpavle/slog/issues/2

Slog gives a neighborhood a single place to share updates, discover and organize local events, comment and discuss on posts, and reach agreements through community polls.

## Problem or goal

Neighborhoods lack a dedicated digital space for local communication, event coordination, and collaborative decision-making. Residents rely on fragmented tools (group chats, social media, email chains) that are noisy, not neighborhood-scoped, and have no built-in way to reach agreements.

## Target users

- **Residents** of a neighborhood or local community who want to stay informed and connected.
- **Community organizers** who create events, post updates, and facilitate group decisions.

## MVP scope

- **Neighborhood feed** — residents post updates (text, optional image) visible to their neighborhood. Low-friction posting is a top priority.
- **Comments** — residents comment on posts to discuss updates (replaces standalone messaging).
- **Polls** — a post type that lets residents vote on options; the result is the community agreement.
- **Local events** — create, discover, and RSVP to neighborhood events.
- **Authentication** — sign up / sign in (Supabase Auth).
- **Neighborhood membership** — join or create a neighborhood; content scoped to the neighborhood.

## Out of scope

- Direct messages (DMs) between residents
- Payments or marketplace features
- Multi-neighborhood federation or cross-neighborhood content
- Admin moderation dashboard (beyond basic author controls)
- Push notifications (deferred to post-MVP)
- Media-heavy content (video uploads, stories)
- Analytics or reporting dashboards

## Platform

Cross-platform mobile and web app — Expo (React Native) targeting iOS, Android, and Web.

## Stack

- **Runtime / framework:** Expo (React Native) with Expo Router
- **Language:** TypeScript
- **Backend / BaaS:** Supabase (Postgres, Auth, Realtime, Storage)
- **Client SDK:** @supabase/supabase-js
- **Styling:** NativeWind (Tailwind CSS for React Native)

## UI/UX direction

- Friendly, approachable tone with a community feel.
- Dark and light theme support.
- Feed-first home screen; bottom tab navigation: Feed · Events · Profile (three tabs).
- Low-friction posting is the top UX priority — tap-to-post with minimal required fields, fast compose flow.
- Comments live inline under posts — no separate messaging surface.
- Agreements surface as polls (a post type) in the feed; results are visible once voting closes or a threshold is met.

## Constraints and integrations

- **Auth:** Supabase Auth (email/password to start; social login deferred).
- **Realtime:** Supabase Realtime for live feed updates and comments.
- **Storage:** Supabase Storage for profile images and event media.
- **Deployment:** Expo EAS for mobile builds; Supabase hosted for backend.

## Milestone plan

- **M0 — Discovery and decisions:** Validate the problem, target users, scope, stack, and baseline decisions.
- **M1 — Foundation and setup:** Establish the repo, environments, workflow surfaces, and shared architecture foundations.
- **M2 — Core MVP workflows:** Deliver the central user-facing workflows that make the MVP usable (feed, comments, polls, events, auth, neighborhoods).
- **M3 — Polish, QA, docs:** Close quality gaps, align docs, and reduce launch risk.
- **M4 — Release and launch:** Final release preparation, rollout, and launch follow-through.

## Success criteria

- A resident can sign up, join a neighborhood, and see the neighborhood feed.
- A resident can post an update and it appears in the feed in real time.
- A resident can comment on a post and the comment appears inline.
- A resident can create a poll and others can vote; the result is displayed.
- A resident can create an event and others can RSVP.
