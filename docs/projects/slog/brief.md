# Project brief: Slog — Local Community App

> **Status:** Draft · **Mode:** Greenfield · **Readiness:** Basics complete

## Problem or goal

Neighborhoods lack a dedicated digital space for local communication, event coordination, and collaborative decision-making. Residents rely on fragmented tools (group chats, social media, email chains) that are noisy, not neighborhood-scoped, and have no built-in way to reach agreements.

Slog gives a neighborhood a single place to share updates, discover and organize local events, comment and discuss on posts, and reach agreements through community polls.

## Target users

- **Residents** of a neighborhood or local community who want to stay informed and connected.
- **Community organizers** who create events, post updates, and facilitate group decisions.

## MVP scope

1. **Neighborhood feed** — residents post updates (text, optional image) visible to their neighborhood. Low-friction posting is a top priority.
2. **Comments** — residents comment on posts to discuss updates (replaces standalone messaging).
3. **Polls** — a post type that lets residents vote on options; the result is the community agreement.
4. **Local events** — create, discover, and RSVP to neighborhood events.
5. **Authentication** — sign up / sign in (Supabase Auth).
6. **Neighborhood membership** — join or create a neighborhood; content scoped to the neighborhood.

## Out of scope

- Direct messages (DMs) between residents
- Payments or marketplace features
- Multi-neighborhood federation or cross-neighborhood content
- Admin moderation dashboard (beyond basic author controls)
- Push notifications (deferred to post-MVP)
- Media-heavy content (video uploads, stories)
- Analytics or reporting dashboards

## Platform

Cross-platform mobile and web app — **Expo (React Native)** targeting iOS, Android, and Web.

## Stack

| Layer | Choice |
|---|---|
| Runtime / framework | Expo (React Native) with Expo Router |
| Language | TypeScript |
| Backend / BaaS | Supabase (Postgres, Auth, Realtime, Storage) |
| Client SDK | `@supabase/supabase-js` |
| Styling | *(to be decided)* |

## UI/UX direction

- Friendly, approachable tone with a community feel.
- **Dark and light theme** support.
- Feed-first home screen; **bottom tab navigation: Feed · Events · Profile** (three tabs).
- **Low-friction posting** is the top UX priority — tap-to-post with minimal required fields, fast compose flow.
- Comments live inline under posts — no separate messaging surface.
- Agreements surface as **polls** (a post type) in the feed; results are visible once voting closes or a threshold is met.

## Constraints and integrations

- **Auth:** Supabase Auth (email/password to start; social login deferred).
- **Realtime:** Supabase Realtime for live feed updates and comments.
- **Storage:** Supabase Storage for profile images and event media.
- **Deployment:** Expo EAS for mobile builds; Supabase hosted for backend.

## Success criteria

1. A resident can sign up, join a neighborhood, and see the neighborhood feed.
2. A resident can post an update and it appears in the feed in real time.
3. A resident can comment on a post and the comment appears inline.
4. A resident can create a poll and others can vote; the result is displayed.
5. A resident can create an event and others can RSVP.
