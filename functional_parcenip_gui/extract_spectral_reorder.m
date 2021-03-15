function [sortedB,p,v2] = extract_spectral_reorder(B)

% function that spectrally reorders a matrix
% Matlab implementation of an algorithm in supplemetary text of: Johansen-Berg et al. 10.1073/pnas.0403743101. 
% For in depth explanation of algorithm, see Barnard, S.T., Pothen, A., & Simon, H.D. (1995) Numer. Linear Algebra Appl. 2,317-334 
% 
% Function takes the form of:
% [sortedB, p]= extract_spectral_reorder(B)
% B = correlation matrix (values between -1 and 1)
% sortedB = spectrally reordered matrix
% p = the reordering vector that allows you to reorder your subjects in the
% same way as your matrix (sortedB)
%
% note if you only assign one output (i.e. of the form sortedB = extract_spectral_reorder(B), only the spectrally reordered matrix - not the reordering vector - will be produced)
%
% Produced for the ExTracT project - Claude J. Bajada 
%
% Neuroscience and Aphasia Research Unit (NARU)
% University of Manchester
% 2014
%
% Edited by Owen Falzon - University of Malta
  
    % remove any NaNs or Infs from the matrix
    if sum(sum((isnan(B)))) > 0
        
        B(isnan(B)) = 0;
        
    end
    
    if sum(sum((isinf(B)))) > 0
        
        B(isinf(B)) = 0;
        
    end
    
    if min(min(B)) < 0
    
        C = B + 1; % compute C which removes the negative values from the correlation matrix (ie values from 0 - 2; 0 = anticorrelated; 2 = correlated)
    
    else
        
        C = B; % if there are no negative values (eg in euclidian distance matrices) do not add one to Matrix B
        
    end
    
    % create the laplacian matrix. 
    % For all non diagonal elements, populate matrix Q with the negative
    % value of matrix C
    % For all the diagonal element, sum across the rows (excluding the
    % diagonal element) and populate the diagonal of Q with that sum

    Q = C - diag(diag(C));
    Q_diag = diag(sum(Q));
    Q = -Q + Q_diag;
    
    % Populate all the non diagonals of matrix t with zeros
    % Populate the diagonal elements of matrix t with 1 over the square
    % root of the sum of the rows (or columns - matrix is symmetric)

    t = 1 ./ sqrt(sum(C));
    t = diag(t);

    D = t * Q * t; % compute matrix D (? normalised laplacian)

    [v, lamda] = eig(D); % find the eigenvalues and eigenvectors of matrix D

    lamda_vector = (diag(lamda))'; % converts the diagonal matrix of eigenvalues into a vector
    
    lamda_sorted = sort(lamda_vector); % sort the eigenvalues in ascending order
    
    lamda_sm = lamda_sorted(2); % find the second smallest eigenvalue 
    
    [~,j] = find(lamda == lamda_sm); % isolate the second smallest eigenvalue

    v2 = t * (v(:,j)); % find the Fiedler vector v(:,j) and scale it by computing t * v
    [~,p] = sort(v2); % sort v2 in ascending order and obtain the permutation matrix p

    sortedB = B(p,:); % sort the original matrix my p
    sortedB = sortedB(:,p);

end


