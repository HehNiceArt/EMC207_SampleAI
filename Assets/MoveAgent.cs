using UnityEngine;
using UnityEngine.AI;

public class MoveAgent : MonoBehaviour
{
    [SerializeField] Camera cam;
    [SerializeField] GameObject targetObject;

    GameObject go;

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out RaycastHit hit))
            {
                NavMeshAgent agent = GetComponent<NavMeshAgent>();
                agent.SetDestination(hit.point);
            }
        }
    }

}
