#set heading(numbering: none)
= Code Appendix

#figure(
  kind: image,
  caption: [OnJoinedRoomHandler - function responsible for recovering the ready counter upon joining a room],
  text()[
    ```cs
    private async void OnJoinedRoomHandler(IRoom _room) {
        // Let Ubiq update Peers list
        await Task.Delay(100);

        if (roomClient.Peers.Count() == 0 && !_room.Name.IsNullOrEmpty()) {
            return;
        }

        if (context.Scene != null) {
            context.SendJson(new RecoverCurrentCounterRequestMessage());
        } else {
            Debug.LogWarning(
                "Network context is not available, retry send in one second"
            );
            // Wait a second before sending a message: this allow to be sure about
            // a complete connection between a new peer and existing peers.
            await Task.Delay(1000);
            OnJoinedRoomHandler(_room);
        }
    }
    ```
  ],
)<onjoinedroomhandler>

#figure(
  kind: image,
  caption: [GetSpawnPoint - returns the position and rotation of a random point where to spawn a player according its UUID],
  text()[
    ```cs
    private (Vector3 position, Quaternion rotation) GetSpawnPoint(
      bool _isGameSpwanPoint
    ) {
        RoomClient roomClient = NetworkReferenceManager.Instance.RoomClient;
        Transform centerPoint = _isGameSpwanPoint ?
          ameSpawnPointCenter : roomLobbySpawnPointCenter;
        Quaternion rotation = centerPoint.rotation;

        int hash = roomClient.Me.uuid.GetHashCode();
        float angle = (hash & 0x7FFFFFFF) % 360 * Mathf.Deg2Rad;
        Vector3 candidatePosition = centerPoint.position +
          new Vector3(Mathf.Cos(angle), 0, Mathf.Sin(angle)) * spawnPointRadius;

        // Nudge if too close to an already-assigned point
        foreach (IPeer peer in roomClient.Peers) {
            int otherHash = peer.uuid.GetHashCode();
            float otherAngle = (otherHash & 0x7FFFFFFF) % 360 * Mathf.Deg2Rad;
            Vector3 otherPosition = centerPoint.position +
              new Vector3(Mathf.Cos(otherAngle), 0, Mathf.Sin(otherAngle)) *
              spawnPointRadius;

            if (Vector3.Distance(candidatePosition, otherPosition) < 1f) {
                // Nudge 45 degrees away
                angle += 45 * Mathf.Deg2Rad;
            }
            candidatePosition = centerPoint.position +
              new Vector3(Mathf.Cos(angle), 0, Mathf.Sin(angle)) * spawnPointRadius;
        }

        return (candidatePosition, rotation);
    }
    ```
  ],
)<getspawnpoint>

#figure(
  kind: image,
  caption: [ProcessMessage - function responsible for managing the position of shared objects],
  text()[
    ```cs
     public override void ProcessMessage(ReferenceCountedSceneGraphMessage _message) {
        MovementMessage message = _message.FromJson<MovementMessage>();

        if (interactable != null) {
            // If an interactable is present and owner is set to true,
            // the interactable has to be disabled and viceversa
            interactable.enabled = !message.IsOwned;
        }

        Pose pose = Transforms.ToWorld(message.Pose, Context.Scene.transform);
        Transform.SetPositionAndRotation(pose.position, pose.rotation);

        if (TryGetComponent(out Rigidbody rb)) {
            // Disable gravity if rigidbody is present
            rb.useGravity = !message.IsOwned;
        }

        if (message.IsOwned) {
            // If object is taken by another,
            // the current player is no longer the amISender
            AmISender = false;
        }
    }
    ```
  ],
)<processmessage>

#figure(
  kind: image,
  caption: [HandleSpectatorChange - function activated when the spectator mode manager requests spectator mode activation],
  text()[
    ```cs
    private IEnumerator HandleSpectatorChange(string _playerUUID) {
        if (NetworkReferenceManager.Instance.RoomClient.Me.uuid == _playerUUID) {
            // If a player lost play the lost sound. Since this function can be called
            // both when spectator mode has to be activated (enable = false -> true)
            // and deactivated (enable = true -> false), the sound has to play only
            // when the spectator mode is being activated (enable = false -> true)

            lostAudioSource.Play();

            yield return new WaitUntil(() => !lostAudioSource.isPlaying);
        }

        if (
            _playerUUID == playerUUID ||
            (playerUUID == "Local Avatar" &&
            _playerUUID == NetworkReferenceManager.Instance.RoomClient.Me.uuid)
        ) {
            UpdateVisibility();
        }
    }
    ```
  ],
)<handlespectatorchange>
