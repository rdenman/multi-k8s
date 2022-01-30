docker build -t rdenman/multi-client:latest -t rdenman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rdenman/multi-server:latest -t rdenman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rdenman/multi-worker:latest -t rdenman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rdenman/multi-client:latest
docker push rdenman/multi-client:$SHA
docker push rdenman/multi-server:latest
docker push rdenman/multi-server:$SHA
docker push rdenman/multi-worker:latest
docker push rdenman/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=rdenman/multi-client:$SHA
kubectl set image deployments/server-deployment server=rdenman/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rdenman/multi-worker:$SHA
