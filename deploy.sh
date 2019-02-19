docker build -t rutvikpensionwar/multi-client:latest -t rutvikpensionwar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rutvikpensionwar/multi-server:latest -t rutvikpensionwar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rutvikpensionwar/multi-worker:latest -t rutvikpensionwar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rutvikpensionwar/multi-client:latest
docker push rutvikpensionwar/multi-server:latest
docker push rutvikpensionwar/multi-worker:latest

docker push rutvikpensionwar/multi-client:$SHA
docker push rutvikpensionwar/multi-server:$SHA
docker push rutvikpensionwar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rutvikpensionwar/multi-server:$SHA
kubectl set image deployments/client-deployment client=rutvikpensionwar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rutvikpensionwar/multi-worker:$SHA