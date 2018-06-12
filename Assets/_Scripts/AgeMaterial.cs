using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class AgeMaterial : MonoBehaviour {
    
    Material mat;
    [SerializeField] [Range(0.0f,1.0f)]float materialAge = 0.0f;

	void Start () {
        mat = GetComponent<Renderer>().sharedMaterial;
	}

    private void Update()
    {
        mat.SetFloat("_Blend", materialAge); 
    }

    public void SetMaterialAge(float _slider){
        materialAge = _slider;
    }

}
