#set heading(numbering: none)
= Code Appendix

#figure(
  kind: image,
  caption: [OnJoinedRoomHandler - function responsible of recovering the ready counter upon joining a room],
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
            Debug.LogWarning("Network context is not available, retry send in one second");
            await Task.Delay(1000); // Wait a second before sending a message: this allow to be sure about a complete connection between a new peer and existing peers.
            OnJoinedRoomHandler(_room);
        }
    }
    ```
  ]
)<onjoinedroomhandler>

#figure(
  kind: image,
  caption: [ProcessMessage - function responsible of managing position of shared objects],
  text()[
    ```cs
     public override void ProcessMessage(ReferenceCountedSceneGraphMessage _message) {
        MovementMessage message = _message.FromJson<MovementMessage>();

        if (interactable != null) {
            // If an interactable is present and owner is set a true the interactable has to be disabled and viceversa
            interactable.enabled = !message.IsOwned;
        }

        Pose pose = Transforms.ToWorld(message.Pose, Context.Scene.transform);
        Transform.SetPositionAndRotation(pose.position, pose.rotation);

        if (TryGetComponent(out Rigidbody rb)) { // disable gravity if rigidbody is present
            rb.useGravity = !message.IsOwned;
        }

        if (message.IsOwned) {
            // If object is taken by another, the current player is no longer the amISender
            AmISender = false;
        }
    }
    ```
  ]
)<processmessage>

#figure(
  kind: image,
  caption: [HandleSpectatorChange - function activated when the spectator mode manager reuqest spectator mode activation],
  text()[
    ```cs
    private IEnumerator HandleSpectatorChange(string receivedPlayerUUID) {
        if (playerUUID == "Local Avatar" && !enable) {
            //If a player lost play the lost sound. Since this function can be called both when spectator mode is to be activated (enable = false -> true) and deactivated (enable = true -> false), the sound has to play only when the spectator mode is being activated (enable = false -> true)

            lostAudioSource.Play();

            yield return new WaitUntil(() => !lostAudioSource.isPlaying);
        }

        if (receivedPlayerUUID == playerUUID || (playerUUID == "Local Avatar" && receivedPlayerUUID == NetworkReferenceManager.Instance.RoomClient.Me.uuid)) {
            UpdateVisibility();
        }
    }
    ```
  ]
)<handlespectatorchange>