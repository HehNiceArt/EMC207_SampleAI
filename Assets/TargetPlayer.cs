using UnityEngine;
using UnityEngine.AI;

public class TargetPlayer : MonoBehaviour
{
    [SerializeField] Transform player;
    [SerializeField] float speed = 5f;
    [SerializeField] float killDistance = 1f;
    [SerializeField] GameObject gameoverui;

    NavMeshAgent agent;

    void Start()
    {
        agent = GetComponent<NavMeshAgent>();
        agent.speed = speed;
        gameoverui.SetActive(false);
    }

    void Update()
    {
        agent.SetDestination(player.position);

        float distToPlayer = Vector3.Distance(transform.position, player.position);
        if (distToPlayer < killDistance)
        {
            Debug.Log("Player killed!");
            gameoverui.SetActive(true);
            Time.timeScale = 0f; // Pause the game
        }
    }
}
