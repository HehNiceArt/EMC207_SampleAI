using UnityEngine;

public class CamMove : MonoBehaviour
{
    [SerializeField] private Transform target;    // Reference to player transform
    [SerializeField] private float smoothSpeed = 5f;
    [SerializeField] private Vector3 offset = new Vector3(0, 2, -10); // Adjust Y and Z as needed

    private void LateUpdate()
    {
        if (target == null) return;

        // Only follow X position, keep Y and Z constant
        Vector3 desiredPosition = new Vector3(
            transform.position.x,
            transform.position.y,
            target.position.z + offset.z
        );

        // Smoothly move camera to desired position
        Vector3 smoothedPosition = Vector3.Lerp(transform.position, desiredPosition, smoothSpeed * Time.deltaTime);
        transform.position = smoothedPosition;
    }
}
