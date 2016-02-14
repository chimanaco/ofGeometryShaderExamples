#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    // Load an image
    image.load( "Earthmap1000x500.jpg" );
    
    // Create mesh from sphere
    mesh = ofSpherePrimitive(200, 40).getMesh();
    for (int i = 0; i < mesh.getVertices().size(); i++) {
        ofVec2f texCoord = mesh.getTexCoord(i);
        texCoord.x *= image.getWidth();
        texCoord.y = (1.0 - texCoord.y) * image.getHeight();
        mesh.setTexCoord(i, texCoord);
    }
    
    doShader = true;
    
    shader.setGeometryInputType(GL_TRIANGLE_STRIP);
    shader.setGeometryOutputType(GL_TRIANGLE_STRIP);
    shader.setGeometryOutputCount(3);
    shader.load("120/vert.glsl", "120/frag.glsl", "120/geom.glsl");
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    //Set a background
    ofBackground( 0 );

    //Enable z-buffering
    ofEnableDepthTest();
    
    cam.begin();
    
    ofPushMatrix();
    
    ofRotate(ofGetElapsedTimef() * 10, 0, 1, 0);

    if(doShader) {
        shader.begin();
        shader.setUniformTexture("tex0", image.getTexture() , 1 );
        shader.setUniform1f("time", ofGetElapsedTimef());
    } else {
        //Use image's texture for drawing
        image.bind();
    }
    
    //Draw mesh
    mesh.draw();
    
    if(doShader) {
        shader.end();
    } else {
        //End using image's texture
        image.unbind();
    }
    
    ofPopMatrix();

    cam.end();
    
    ofDisableDepthTest();
    
    ofDrawBitmapString("fps: " + ofToString((int)ofGetFrameRate()) + "\nPress 's' to toggle shader: " + (doShader ? "ON" : "OFF"), 20, 20);
}

//--------------------------------------------------------------
void ofApp::keyPressed  (int key){
	if( key == 's' || key == 'S' ){
		doShader = !doShader;
	}
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){ 
	
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
	
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
	
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}

